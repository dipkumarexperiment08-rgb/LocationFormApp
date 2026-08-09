namespace LocationFormApp.Models
{
    public class City
    {
        public int CityId { get; set; }

        public string CityName { get; set; } = string.Empty;

        public int StateId { get; set; }

        public bool IsActive { get; set; }
    }
}