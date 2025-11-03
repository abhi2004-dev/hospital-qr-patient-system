const Patient = require("../models/Patient");
const QRCode = require("qrcode");

// Register a new patient and generate QR code
exports.registerPatient = async (req, res) => {
  try {
    const { name, age, gender, phone, address, medicalHistory } = req.body;

    const newPatient = new Patient({
      name,
      age,
      gender,
      phone,
      address,
      medicalHistory,
    });

    // Generate QR code with patient ID
    const qrData = `patient:${newPatient._id}`;
    const qrImage = await QRCode.toDataURL(qrData);
    newPatient.qrCode = qrImage;

    await newPatient.save();

    res.status(201).json({ success: true, patient: newPatient });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
