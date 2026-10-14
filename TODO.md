# httpdd TODO

Improvements carried over from the October 2026 spec review (RFC 9110/9111/9112 baseline held here; the rest pending).

## Decision paths

- [ ] Expand the collapsed `is_authorized` decision: model `WWW-Authenticate` challenge generation on 401, `Proxy-Authenticate`/`Proxy-Authorization` lanes (RFC 9110 §11), and modern auth transports (`Client-Cert`/`Client-Cert-Chain` RFC 9440, message signatures `Signature`/`Signature-Input` RFC 9421) as separate failures.
- [ ] Conditional-PUT semantics per RFC 9110: failed `If-Match`/`If-Unmodified-Since` supersedes other checks; `Content-Range` on PUT is a request modifier (§9.3.4/§14.4) so a failed range-PUT is no longer a blanket 400 — revisit `process_partial_put`/`create_partial_put` and add a 416 path.
- [ ] Redirect handling: RFC 9110 §15.4 defines the redirect algorithmically across 301/302/303/307/308; add a shared "redirect" note/bock with Cross-Origin hints and remove the duplicated `410_GONE` transition line (cosmogol lines 194-195).
- [ ] URI deprecations: `userinfo` in http(s) URIs is now a generation error (RFC 9110 §4.2.2); show in `is_uri_too_long`/authority decisions.

## Headers worth a footnote or node

- [ ] `Priority` (RFC 9218), `Proxy-Status` (RFC 9209), `Repr-Digest`/`Content-Digest` (RFC 9530), compression dictionaries (RFC 9842), cache groups (RFC 9875), incremental forwarding (RFC 10036).
- [ ] RateLimit (`RateLimit`/`RateLimit-Policy`) is still draft-ietf-httpapi-ratelimit-headers — revisit once it becomes an RFC; same for `Retry-After-RateLimit`.

## Coverage notes

- [ ] Per-block doc pages (`doc/README_*.md`) still link a removed `httpdd.png` via rawgithub; point them at `../httpdd.fsm.png` like `doc/README.md`.
- [ ] Layout (PNG/SVG) is generated from the JointJS page; script the PNG export (`make dist` or a headless screenshot) so `httpdd.fsm.png` regeneration is repeatable.
- [ ] Wayback-style trailing validations cached in the JSON should be co-verified in `make check` (currently parse-only).
- [ ] HTTP/2 (RFC 9113) and HTTP/3 (RFC 9114) version-specific pathways (misdirected-request flags, GOAWAY semantics) stay out-of-diagram — revisit if modeling is ever split per version.

## Watch

- [ ] draft-ietf-httpbis-resumable-upload — `104 Upload Resumption Supported` registered 2024-11; land once the draft becomes an RFC.
- [ ] draft-ietf-httpbis-rfc6265bis (cookie refresh) — in RFC Editor queue; RFC 6265 is the operative spec for now.
