//Haversine Function to calculate the 

exports.haversineDistance = (coords1, coords2) => {
  const toRadians = degrees => degrees * Math.PI / 180;
  const R = 6371; // Radius of the Earth in kilometers
  const dLat = toRadians(coords2.latitude - coords1.latitude);
  const dLon = toRadians(coords2.longitude - coords1.longitude);
  const lat1 = toRadians(coords1.latitude);
  const lat2 = toRadians(coords2.latitude);

  const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c;
  return distance;
};