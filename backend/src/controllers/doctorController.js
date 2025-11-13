import Doctor from "../models/Doctor.js";

export const getDoctorProfile = async (req, res) => {
  try {
    const doc = await Doctor.findById(req.params.id);
    if (!doc) return res.status(404).json({ success:false, message: "Not found" });
    res.json({ success:true, doctor: doc });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};
