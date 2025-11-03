import mongoose from "mongoose";

const patientSchema = new mongoose.Schema({
  patientId: {
    type: String,
    required: true,
    unique: true, // Used for QR linking
  },
  name: {
    type: String,
    required: true,
  },
  age: Number,
  gender: String,
  bloodGroup: String,
  phone: {
    type: String,
    required: true,
    unique: true,
  },
  email: String,
  guardianEmail: String,
  address: String,
  allergies: [String],
  lastVisit: Date,
  password: {
    type: String,
    required: false,
  },
  prescriptions: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Prescription",
    },
  ],
  qrCode: String, // Stores the generated QR Code image as Base64
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Patient = mongoose.model("Patient", patientSchema);

export default Patient;
