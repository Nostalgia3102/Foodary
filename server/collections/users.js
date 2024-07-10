const { db } = require("../utils/admin.js");

exports.users = async (req, res) => {
    const usersRef = db.collection('users');
    try {
        console.log("inside users module");
        await usersRef.get().then((snapshot) => {
            const data = snapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data(),
            }));
            console.log(data);
            return res.status(201).json(data);
        })
    } catch (error) {
        return res
            .status(500)
            .json({ general: "Something went wrong, please try again --> Users" });
    }
};