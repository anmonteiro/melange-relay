(* @sourceLoc Test_connections.re *)
(* @generated *)
[%%bs.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment_loggedInUser_friendsConnection_edges_node = {
    id: string [@live];
  }
  and fragment_loggedInUser_friendsConnection_edges = {
    node: fragment_loggedInUser_friendsConnection_edges_node option;
  }
  and fragment_loggedInUser_friendsConnection = {
    edges: fragment_loggedInUser_friendsConnection_edges option array option;
  }
  and fragment_loggedInUser = {
    friendsConnection: fragment_loggedInUser_friendsConnection;
  }
  type fragment = {
    loggedInUser: fragment_loggedInUser;
  }
end

module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%bs.raw 
    {json|{}|json}
  ]
  let fragmentConverterMap = ()
  let convertFragment v = Melange_relay.convertObj v 
    fragmentConverter 
    fragmentConverterMap 
    Js.undefined
  end

type t
type fragmentRef
external getFragmentRef:
  [> | `TestConnections3_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

let connectionKey = "TestConnectionsTest_user_user_friendsConnection"

[@@bs.inline]
[%%private
  external internal_makeConnectionId: Melange_relay.dataId -> (_ [@bs.as "TestConnectionsTest_user_user_friendsConnection"]) -> 'arguments -> Melange_relay.dataId = "getConnectionID"
[@@live] [@@bs.module "relay-runtime"] [@@bs.scope "ConnectionHandler"]

]let makeConnectionId (connectionParentDataId: Melange_relay.dataId)  =
  let args = () in
  internal_makeConnectionId connectionParentDataId args
module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types

  let getConnectionNodes: Types.fragment_loggedInUser_friendsConnection -> Types.fragment_loggedInUser_friendsConnection_edges_node array = fun connection -> 
    begin match connection.edges with
      | None -> [||]
      | Some edges -> edges
        |. Belt.Array.keepMap(function 
          | None -> None
          | Some edge -> edge.node
        )
    end


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.fragmentNode


let node: operationType = [%bs.raw {json| {
  "argumentDefinitions": [
    {
      "defaultValue": 2,
      "kind": "LocalArgument",
      "name": "count"
    },
    {
      "defaultValue": "",
      "kind": "LocalArgument",
      "name": "cursor"
    }
  ],
  "kind": "Fragment",
  "metadata": {
    "connection": [
      {
        "count": "count",
        "cursor": "cursor",
        "direction": "forward",
        "path": [
          "loggedInUser",
          "friendsConnection"
        ]
      }
    ]
  },
  "name": "TestConnections3_user",
  "selections": [
    {
      "alias": null,
      "args": null,
      "concreteType": "User",
      "kind": "LinkedField",
      "name": "loggedInUser",
      "plural": false,
      "selections": [
        {
          "alias": "friendsConnection",
          "args": null,
          "concreteType": "UserConnection",
          "kind": "LinkedField",
          "name": "__TestConnectionsTest_user_user_friendsConnection_connection",
          "plural": false,
          "selections": [
            {
              "alias": null,
              "args": null,
              "concreteType": "UserEdge",
              "kind": "LinkedField",
              "name": "edges",
              "plural": true,
              "selections": [
                {
                  "alias": null,
                  "args": null,
                  "concreteType": "User",
                  "kind": "LinkedField",
                  "name": "node",
                  "plural": false,
                  "selections": [
                    {
                      "alias": null,
                      "args": null,
                      "kind": "ScalarField",
                      "name": "id",
                      "storageKey": null
                    },
                    {
                      "alias": null,
                      "args": null,
                      "kind": "ScalarField",
                      "name": "__typename",
                      "storageKey": null
                    }
                  ],
                  "storageKey": null
                },
                {
                  "alias": null,
                  "args": null,
                  "kind": "ScalarField",
                  "name": "cursor",
                  "storageKey": null
                }
              ],
              "storageKey": null
            },
            {
              "alias": null,
              "args": null,
              "concreteType": "PageInfo",
              "kind": "LinkedField",
              "name": "pageInfo",
              "plural": false,
              "selections": [
                {
                  "alias": null,
                  "args": null,
                  "kind": "ScalarField",
                  "name": "endCursor",
                  "storageKey": null
                },
                {
                  "alias": null,
                  "args": null,
                  "kind": "ScalarField",
                  "name": "hasNextPage",
                  "storageKey": null
                }
              ],
              "storageKey": null
            }
          ],
          "storageKey": null
        }
      ],
      "storageKey": null
    }
  ],
  "type": "Query",
  "abstractKey": null
} |json}]

