const { db } = require("../utils/admin.js");
const { haversineDistance } = require("../utils/haversine.js");

const listOfRestaurants = new Set([]);


const fetchVendors = async () => {
  const snapshot = await db.collection('vendors').get();
  const vendors = [];
  snapshot.forEach(doc => {
    vendors.push(doc.data());
  });
  return vendors;
};

const main = async (lat, long) => {
  const vendors = await fetchVendors();

  if (vendors.length > 1) {
    const coords1 = {
      latitude: lat,
      longitude: long
    };

    vendors.forEach(e);

    function e(item) {
      const coords2 = {
        latitude: item.location._latitude,
        longitude: item.location._longitude
      };

      const distance = haversineDistance(coords1, coords2);
      console.log(`Distance between User's Location and ${item.name} is ${distance.toFixed(2)} km`);

      if (distance <= 10) {
        listOfRestaurants.add(`${item.vendorId}`);
      }
      console.log("hello world", listOfRestaurants);
    }

    // Convert Set to Array after populating listOfRestaurants
    const array = Array.from(listOfRestaurants);

    // Return the array or use it as needed
    return array;

  } else {
    console.log('Not enough vendor data to calculate distances.');
    return [];
  }
};

const array = Array.from(listOfRestaurants);
console.log("hii");
console.log(array);

module.exports = { main, array };