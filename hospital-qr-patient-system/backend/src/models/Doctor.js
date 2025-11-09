import mongoose from "mongoose";

const doctorSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  password: String,
  specialization: String,
  hospital: String,
  userId: String,
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("Doctor", doctorSchema);
