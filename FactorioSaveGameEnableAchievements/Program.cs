using System.IO.Compression;
using System.Text;

namespace FactorioSaveGameEnableAchivements
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var fileProcessor = new FileProcessor();
            Console.WriteLine("Enter the path to the save file: ");
            var path = Console.ReadLine().Trim('"');
            var extractDirectoryPath = $"{Path.GetDirectoryName(path)}\\{Path.GetFileNameWithoutExtension(path)}";
            Console.WriteLine("Extracting save file to: " + extractDirectoryPath);
            ZipFile.ExtractToDirectory(path, extractDirectoryPath, true);
            var files = Directory.GetFiles(extractDirectoryPath, "level.dat*", SearchOption.AllDirectories)
                                 .Where(x => !x.EndsWith(".datmetadata") && !x.EndsWith(".bin"))
                                 .ToArray();

            foreach (var file in files)
            {
                var result = fileProcessor.UnpackZLib(file);
                string asciiString = Encoding.ASCII.GetString(result);
                if (asciiString.Contains("command-ran"))
                {
                    var position = asciiString.IndexOf("command-ran");
                    var findings = FindPattern(result, new byte[] { 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff });
                    var closest = findings.OrderBy(x => Math.Abs(position - x)).ToList();

                    if (closest.Count > 0 && closest[0] - 7 >= 0)
                    {
                        if (result[closest[0] - 7] == 1)
                        {
                            result[closest[0] - 7] = 0;  // activate achievements disabled by commands
                        }
                    }
                    
                    if (closest.Count > 0 && closest[0] - 6 >= 0)
                    {
                        if (result[closest[0] - 6] == 1)
                        {
                            result[closest[0] - 6] = 0;  // activate achievements disabled by map editor
                        }
                    }

                    var packed = fileProcessor.PackZLib(result);
                    File.WriteAllBytes(file, packed);  // replace existing
                    Console.WriteLine("patched finding");
                }
            }
            Console.WriteLine("Backing up original save file");
            File.Move(path, path + ".bak", true);
            Console.WriteLine("Creating new save file");
            ZipFile.CreateFromDirectory(extractDirectoryPath, path, CompressionLevel.Optimal, false);
            Console.WriteLine("Cleaning up");
            Directory.Delete(extractDirectoryPath, true);
            Console.WriteLine("Done");
        }

        static List<int> FindPattern(byte[] array, byte[] pattern)
        {
            List<int> findings = new List<int>();
            if (array == null || pattern == null || array.Length == 0 || pattern.Length == 0 || pattern.Length > array.Length)
            {
                return findings;
            }

            for (int i = 0; i <= array.Length - pattern.Length; i++)
            {
                bool found = true;
                for (int j = 0; j < pattern.Length; j++)
                {
                    if (array[i + j] != pattern[j])
                    {
                        found = false;
                        break;
                    }
                }

                if (found)
                {
                    findings.Add(i);
                }
            }

            return findings;
        }
    }
}
