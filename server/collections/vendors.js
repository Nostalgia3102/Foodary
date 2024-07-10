const { db } = require("../utils/admin.js");

exports.vendors = async (req, res) => {
    const vendorsRef = db.collection('vendors');
    try {
        console.log("inside the vendors module");
        await vendorsRef.get().then((snapshot) => {
            const data = snapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data(),
            }));
            console.log(data);
            return res.status(201).json(data);
        })
    } catch (e) {
        return res
            .status(500)
            .json({
                general: "Something went wrong, please try again --> Vendors"
            });
    }
}