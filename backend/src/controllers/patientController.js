import Patient from "../models/Patient.js";
import QRCode from "qrcode";

export const getPatientById = async (req, res) => {
  try {
    const id = req.params.id;
    const p = await Patient.findById(id).populate("prescriptions");
    if (!p) return res.status(404).json({ success:false, message: "Patient not found" });
    res.json({ success:true, patient: p });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};

// simple seed create
export const createPatientSample = async (req, res) => {
  try {
    const newP = await Patient.create({
      patientId: Date.now().toString(),
      name: "John Doe",
      phone: "9998887777",
      bloodGroup: "B+"
    });
    const qr = await QRCode.toDataURL(`patient:${newP._id}`);
    newP.qrCode = qr;
    await newP.save();
    res.json({ success:true, patient: newP });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};
