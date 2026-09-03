/// The backend reserves batch id 0 for "Tata Tertib" — a generic,
/// non-batch-specific entry returned by `/sk/list` alongside real batches.
/// It's hidden from the Standar Kompetensi list (standard_competency_screen)
/// but kept — and given the link-preview treatment — in Peraturan dan Tata
/// Tertib (pengumuman_screen). Keep it as one named constant so both call
/// sites move together if the reserved id ever changes.
const int kTataTertibBatchId = 0;
