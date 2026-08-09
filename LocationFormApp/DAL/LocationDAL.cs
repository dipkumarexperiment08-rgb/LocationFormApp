using LocationFormApp.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace LocationFormApp.DAL
{
    public class LocationDAL
    {
        private readonly string _connectionString;

        public LocationDAL(string connectionString)
        {
            _connectionString = connectionString;
        }

        // Get only active countries
        public List<Country> GetCountries()
        {
            List<Country> countries = new List<Country>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
                    SELECT CountryId, CountryName, IsActive
                    FROM Country
                    WHERE IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Country country = new Country();

                    country.CountryId =
                        Convert.ToInt32(reader["CountryId"]);

                    country.CountryName =
                        reader["CountryName"]?.ToString() ?? "";

                    country.IsActive =
                        Convert.ToBoolean(reader["IsActive"]);

                    countries.Add(country);
                }

                reader.Close();
            }

            return countries;
        }

        // Get all countries for manage enable and disable functionality
        public List<Country> GetAllCountries()
        {
            List<Country> countries = new List<Country>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
            SELECT CountryId, CountryName, IsActive
            FROM Country";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Country country = new Country();

                    country.CountryId =
                        Convert.ToInt32(reader["CountryId"]);

                    country.CountryName =
                        reader["CountryName"]?.ToString() ?? "";

                    country.IsActive =
                        Convert.ToBoolean(reader["IsActive"]);

                    countries.Add(country);
                }

                reader.Close();
            }

            return countries;
        }


        // Get  active states for selected country
        public List<State> GetStatesByCountry(int countryId)
        {
            List<State> states = new List<State>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
                    SELECT StateId, StateName, CountryId, IsActive
                    FROM State
                    WHERE CountryId = @CountryId
                    AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@CountryId",
                    countryId);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    State state = new State();

                    state.StateId =
                        Convert.ToInt32(reader["StateId"]);

                    state.StateName =
                        reader["StateName"]?.ToString() ?? "";

                    state.CountryId =
                        Convert.ToInt32(reader["CountryId"]);

                    state.IsActive =
                        Convert.ToBoolean(reader["IsActive"]);

                    states.Add(state);
                }

                reader.Close();
            }

            return states;
        }


        // Get  active cities for selected state
        public List<City> GetCitiesByState(int stateId)
        {
            List<City> cities = new List<City>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
                    SELECT CityId, CityName, StateId, IsActive
                    FROM City
                    WHERE StateId = @StateId
                    AND IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@StateId",
                    stateId);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    City city = new City();

                    city.CityId =
                        Convert.ToInt32(reader["CityId"]);

                    city.CityName =
                        reader["CityName"]?.ToString() ?? "";

                    city.StateId =
                        Convert.ToInt32(reader["StateId"]);

                    city.IsActive =
                        Convert.ToBoolean(reader["IsActive"]);

                    cities.Add(city);
                }

                reader.Close();
            }

            return cities;
        }


        // Save Country, State and City selected by the  user
        public void InsertLocation(LocationModel model)
        {
            using (SqlConnection con =
                   new SqlConnection(_connectionString))
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_InsertLocation",
                        con);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@CountryId",
                    model.CountryId);

                cmd.Parameters.AddWithValue(
                    "@StateId",
                    model.StateId);

                cmd.Parameters.AddWithValue(
                    "@CityId",
                    model.CityId);

                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
        // Enable or disable country
        public void UpdateCountryStatus(int countryId, bool isActive)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_UpdateCountryStatus",
                    con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@CountryId",
                    countryId);

                cmd.Parameters.AddWithValue(
                    "@IsActive",
                    isActive);

                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
        // Get all states for manage disable and enable functionality
        public List<State> GetAllStates()
        {
            List<State> states = new List<State>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
            SELECT StateId, StateName, CountryId, IsActive
            FROM State";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    State state = new State();

                    state.StateId = Convert.ToInt32(reader["StateId"]);
                    state.StateName = reader["StateName"]?.ToString() ?? "";
                    state.CountryId = Convert.ToInt32(reader["CountryId"]);
                    state.IsActive = Convert.ToBoolean(reader["IsActive"]);

                    states.Add(state);
                }

                reader.Close();
            }

            return states;
        }


        // Get all cities for manage disable and enable functionality
        public List<City> GetAllCities()
        {
            List<City> cities = new List<City>();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
            SELECT CityId, CityName, StateId, IsActive
            FROM City";

                SqlCommand cmd = new SqlCommand(query, con);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    City city = new City();

                    city.CityId = Convert.ToInt32(reader["CityId"]);
                    city.CityName = reader["CityName"]?.ToString() ?? "";
                    city.StateId = Convert.ToInt32(reader["StateId"]);
                    city.IsActive = Convert.ToBoolean(reader["IsActive"]);

                    cities.Add(city);
                }

                reader.Close();
            }

            return cities;
        }


        // Enable and Disable State
        public void UpdateStateStatus(int stateId, bool isActive)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_UpdateStateStatus",
                    con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@StateId", stateId);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                con.Open();

                cmd.ExecuteNonQuery();
            }
        }


        // Enable and Disable City
        public void UpdateCityStatus(int cityId, bool isActive)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_UpdateCityStatus",
                    con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CityId", cityId);
                cmd.Parameters.AddWithValue("@IsActive", isActive);

                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
    }
}