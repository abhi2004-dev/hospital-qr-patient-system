import mongoose from "mongoose";

const prescriptionSchema = new mongoose.Schema({
  patient: { type: mongoose.Schema.Types.ObjectId, ref: "Patient" },
  doctor: { type: mongoose.Schema.Types.ObjectId, ref: "Doctor" },
  medicines: [{ name: String, dose: String, duration: String }],
  notes: String,
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("Prescription", prescriptionSchema);
