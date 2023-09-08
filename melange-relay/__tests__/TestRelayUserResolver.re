/**
 * @RelayResolver
 *
 * @onType User
 * @fieldName fullName
 * @rootFragment TestRelayUserResolver
 *
 * A users full name.
 */

type nonrec t = string;

module Fragment = [%relay
  {|
  fragment TestRelayUserResolver on User {
    firstName
    lastName
  }
|}
];

let default =
  Fragment.makeRelayResolver(user =>
    [@ns.braces] Some((user.firstName ++ {| |}) ++ user.lastName)
  );
