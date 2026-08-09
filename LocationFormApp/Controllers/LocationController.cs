using LocationFormApp.DAL;
using LocationFormApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace LocationFormApp.Controllers
{
    public class LocationController : Controller
    {
        private readonly LocationDAL _locationDAL;

        public LocationController(IConfiguration configuration)
        {
            string connectionString =
                configuration.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException(
                    "DefaultConnection is not configured.");

            _locationDAL = new LocationDAL(connectionString);
        }


        // ============================
        // MAIN PAGE
        // ============================

        public IActionResult Index()
        {
            var viewModel = new LocationViewModel();

            viewModel.Countries =
                _locationDAL.GetCountries();

            viewModel.AllCountries =
                _locationDAL.GetAllCountries();

            viewModel.AllStates =
                _locationDAL.GetAllStates();

            viewModel.AllCities =
                _locationDAL.GetAllCities();

            return View(viewModel);
        }


        // ============================
        // GET STATES
        // ============================

        [HttpGet]
        public JsonResult GetStates(int countryId)
        {
            var states =
                _locationDAL.GetStatesByCountry(countryId);

            return Json(states);
        }


        // ============================
        // GET CITIES
        // ============================

        [HttpGet]
        public JsonResult GetCities(int stateId)
        {
            var cities =
                _locationDAL.GetCitiesByState(stateId);

            return Json(cities);
        }


        // ============================
        // SAVE LOCATION
        // ============================

        [HttpPost]
        public IActionResult Save(LocationModel model)
        {
            _locationDAL.InsertLocation(model);

            return RedirectToAction("Index");
        }


        // ============================
        // COUNTRY STATUS
        // ============================

        [HttpPost]
        public IActionResult UpdateCountryStatus(
            int countryId,
            bool isActive)
        {
            _locationDAL.UpdateCountryStatus(
                countryId,
                isActive);

            return RedirectToAction("Index");
        }


        // ============================
        // STATE STATUS
        // ============================

        [HttpPost]
        public IActionResult UpdateStateStatus(
            int stateId,
            bool isActive)
        {
            _locationDAL.UpdateStateStatus(
                stateId,
                isActive);

            return RedirectToAction("Index");
        }


        // ============================
        // CITY STATUS
        // ============================

        [HttpPost]
        public IActionResult UpdateCityStatus(
            int cityId,
            bool isActive)
        {
            _locationDAL.UpdateCityStatus(
                cityId,
                isActive);

            return RedirectToAction("Index");
        }
    }
}