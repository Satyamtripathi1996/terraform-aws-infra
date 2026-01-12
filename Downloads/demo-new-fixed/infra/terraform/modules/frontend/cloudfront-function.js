function handler(event) {
  // Default: do nothing (safe no-op).
  // You can customize routing here if you want different behavior for root vs app subdomain.
  return event.request;
}
