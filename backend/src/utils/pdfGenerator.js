// stub for PDF generation — in real app use pdfkit / puppeteer
export const generatePatientPDF = async (patient) => {
    // return a small sample text buffer (replace with real PDF bytes)
    return Buffer.from(`Patient Report: ${patient.name}`);
  };
  