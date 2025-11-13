import mongoose from "mongoose";

const patientSchema = new mongoose.Schema({
  patientId: { type: String, required: true, unique: false },
  name: { type: String, required: true },
  age: Number,
  gender: String,
  bloodGroup: String,
  phone: { type: String, unique: false },
  email: String,
  guardianEmail: String,
  address: String,
  allergies: [String],
  lastVisit: Date,
  prescriptions: [{ type: mongoose.Schema.Types.ObjectId, ref: "Prescription" }],
  qrCode: String,
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("Patient", patientSchema);
