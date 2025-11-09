import Prescription from "../models/Prescription.js";
import Patient from "../models/Patient.js";

export const addPrescriptionForPatient = async (req, res) => {
  try {
    const { patientId, doctorId, medicines, notes } = req.body;
    const pres = await Prescription.create({ patient: patientId, doctor: doctorId, medicines, notes });
    await Patient.findByIdAndUpdate(patientId, { $push: { prescriptions: pres._id } });
    res.json({ success:true, prescription: pres });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};
