import mongoose from "mongoose";

const logSchema = new mongoose.Schema({
  userId: String,
  action: String,
  meta: Object,
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("Log", logSchema);
