const {db} = require("../utils/admin.js");
const { haversineDistance } = require("../utils/haversine.js");

const fetchVendors = async () => {
    const snapshot = await db.collection('vendors').get();
    const vendors = [];
    snapshot.forEach(doc => {
      vendors.push(doc.data());
    });
    return vendors;
  };

  exports.main = async () => {
    const vendors = await fetchVendors();
  
    if (vendors.length > 1) {
      const coords1 = {
        latitude: 30.7046483,
        longitude: 76.7178717
      };
      const coords2 = {
        latitude: vendors[1].location._latitude,
        longitude: vendors[1].location._longitude
      };
  
      const distance = haversineDistance(coords1, coords2);
      console.log(`Distance between User's Location and ${vendors[1].name} is ${distance.toFixed(2)} km`);
    } else {
      console.log('Not enough vendor data to calculate distances.');
    }
  };