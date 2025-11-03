import mongoose from "mongoose";

const patientSchema = new mongoose.Schema({
  patientId: {
    type: String,
    required: true,
    unique: true, // will be used to generate QR code
  },
  name: {
    type: String,
    required: true,
  },
  age: Number,
  gender: String,
  bloodGroup: String,
  phone: String,
  email: String,
  guardianEmail: String,
  address: String,
  allergies: [String],
  lastVisit: Date,

  // Relationship to prescriptions
  prescriptions: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Prescription",
    },
  ],

  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Patient = mongoose.model("Patient", patientSchema);
export default Patient;
