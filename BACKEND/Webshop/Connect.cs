using MySqlConnector;

namespace Webshop
{
    public class Connect
    {
        public string Server;
        public string DataBase;
        public string UserName;
        public string Password;

        public string ConnectionString;

        public MySqlConnection kapcsolat;

        public Connect()
        {
            Server = "localhost";
            DataBase = "projectwebshop";
            UserName = "root";
            Password = "";

            ConnectionString = $"SERVER={Server};DATABASE={DataBase};UID={UserName};PWD={Password}";

            kapcsolat = new MySqlConnection(ConnectionString);

            try
            {
                kapcsolat.Open();

                Console.WriteLine("Kapcsolódás sikeres.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Kapcsolódási hiba: {ex.Message}");                    
            }       
            finally
            {
                kapcsolat.Close();
            }
        }

        public MySqlConnection GetConnection()
        {
            var connection = new MySqlConnection(ConnectionString);
            connection.Open();
            return connection;
        
        }    
    }
}
