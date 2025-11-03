import mongoose from "mongoose";

const doctorSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  specialization: String,
  hospitalName: String,
  contactNumber: String,
  accessLogs: [
    {
      patientId: String,
      accessTime: { type: Date, default: Date.now },
      action: String, // e.g. "viewed_basic", "viewed_full", "edited"
    },
  ],
});

const Doctor = mongoose.model("Doctor", doctorSchema);
export default Doctor;
