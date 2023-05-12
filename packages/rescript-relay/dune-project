(lang dune 3.8)

(using melange 0.1)

(generate_opam_files true)

(name reason-relay)

(source
 (github anmonteiro/reason-relay))

(authors "Antonio Nuno Monteiro <anmonteiro@gmail.com>")

(maintainers "Antonio Nuno Monteiro <anmonteiro@gmail.com>")

(homepage "https://github.com/anmonteiro/reason-relay")

(bug_reports "https://github.com/anmonteiro/reason-relay")

(license "MIT")

(package
 (name melange-relay)
 (synopsis "Relay (relay.dev) support for Melange")
 (depends
  (ocaml
   (>= "4.13.0"))
  melange
  reason-react
  (reactjs-jsx-ppx :with-test)))

(package
 (name rescript-relay-ppx)
 (synopsis "Relay (relay.dev) support for Melange")
 (depends
  (ocaml
   (>= "4.13.0"))
  ppxlib
  graphql_parser))
