using System.IO.Compression;
using System.Text;

namespace FactorioSaveGameEnableAchievements
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var fileProcessor = new FileProcessor();
            
            try
            {
                // Prompt the user to enter the path to the save file
                Console.WriteLine("Enter the path to the save file: ");
                var path = Console.ReadLine()?.Trim('"');
                
                // Validate the file path
                if (string.IsNullOrEmpty(path) || !File.Exists(path))
                {
                    Console.WriteLine("Invalid file path. Please check and try again.");
                    return;
                }
                
                // Define the directory to extract the save file
                var extractDirectoryPath = Path.Combine(Path.GetDirectoryName(path)!, Path.GetFileNameWithoutExtension(path)!);
                
                // Extract the save file contents to the specified directory
                Console.WriteLine("Extracting save file to: " + extractDirectoryPath);
                ZipFile.ExtractToDirectory(path, extractDirectoryPath, true);
                
                // Find level.dat files that need to be processed
                var files = Directory.GetFiles(extractDirectoryPath, "level.dat*", SearchOption.AllDirectories)
                                     .Where(x => !x.EndsWith(".datmetadata") && !x.EndsWith(".bin"))
                                     .ToArray();

                if (files.Length == 0)
                {
                    Console.WriteLine("No valid 'level.dat' files found.");
                    return;
                }

                foreach (var file in files)
                {
                    try
                    {
                        // Unpack the ZLib compressed file
                        var result = fileProcessor.UnpackZLib(file);
                        string asciiString = Encoding.ASCII.GetString(result);

                        // Check if the save file contains a command that disables achievements
                        if (asciiString.Contains("command-ran"))
                        {
                            var position = asciiString.IndexOf("command-ran");
                            var findings = FindPattern(result, new byte[] { 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff });
                            var closest = findings.OrderBy(x => Math.Abs(position - x)).ToList();

                            // Enable achievements by modifying specific bytes in the file
                            if (closest.Count > 0 && closest[0] - 7 >= 0 && result[closest[0] - 7] == 1)
                            {
                                result[closest[0] - 7] = 0;  // Enable achievements disabled by commands
                            }

                            if (closest.Count > 0 && closest[0] - 6 >= 0 && result[closest[0] - 6] == 1)
                            {
                                result[closest[0] - 6] = 0;  // Enable achievements disabled by map editor
                            }

                            // Repack and overwrite the modified file
                            var packed = fileProcessor.PackZLib(result);
                            File.WriteAllBytes(file, packed);
                            Console.WriteLine($"Patched {file}");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error processing {file}: {ex.Message}");
                    }
                }

                // Backup the original save file by renaming it with a .bak extension
                Console.WriteLine("Backing up original save file...");
                File.Move(path, path + ".bak", true);

                // Create a new save file with the modified contents
                Console.WriteLine("Creating new save file...");
                ZipFile.CreateFromDirectory(extractDirectoryPath, path, CompressionLevel.Optimal, false);

                // Delete the temporary directory used for processing
                Console.WriteLine("Cleaning up...");
                Directory.Delete(extractDirectoryPath, true);
                Console.WriteLine("Done");
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        // Method to find a specific byte pattern in a byte array
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
