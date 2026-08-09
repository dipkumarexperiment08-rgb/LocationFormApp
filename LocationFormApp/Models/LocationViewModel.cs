using System.Collections.Generic;

namespace LocationFormApp.Models
{
    public class LocationViewModel
    {
        public List<Country> Countries { get; set; } = new();

        public List<Country> AllCountries { get; set; } = new();

        public List<State> AllStates { get; set; } = new();

        public List<City> AllCities { get; set; } = new();
    }
}