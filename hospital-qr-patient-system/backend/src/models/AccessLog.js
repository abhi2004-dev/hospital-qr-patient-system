import mongoose from "mongoose";

const accessLogSchema = new mongoose.Schema({
  doctor: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Doctor",
  },
  patient: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Patient",
  },
  accessType: {
    type: String,
    enum: ["VIEW_BASIC", "VIEW_FULL", "EDIT", "EMERGENCY"],
    required: true,
  },
  accessTime: {
    type: Date,
    default: Date.now,
  },
  otpVerified: {
    type: Boolean,
    default: false,
  },
  status: {
    type: String,
    enum: ["GRANTED", "DENIED"],
    default: "GRANTED",
  },
});

const AccessLog = mongoose.model("AccessLog", accessLogSchema);
export default AccessLog;
