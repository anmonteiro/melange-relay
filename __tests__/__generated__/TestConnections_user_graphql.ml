(* @sourceLoc Test_connections.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment_friendsConnection_edges_node = {
    id: string [@live];
  }
  and fragment_friendsConnection_edges = {
    node: fragment_friendsConnection_edges_node option;
  }
  and fragment_friendsConnection = {
    edges: fragment_friendsConnection_edges option array option;
  }
  type fragment = {
    __id: Melange_relay.dataId [@live];
    friendsConnection: fragment_friendsConnection option;
  }
end

module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
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
  [> | `TestConnections_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

let connectionKey = "TestConnections_user_friendsConnection"

[@@mel.inline]
[%%private
  external internal_makeConnectionId: Melange_relay.dataId -> (_ [@mel.as "TestConnections_user_friendsConnection"]) -> 'arguments -> Melange_relay.dataId = "getConnectionID"
[@@live] [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

]let makeConnectionId (connectionParentDataId: Melange_relay.dataId) ?(onlineStatuses: [`Online | `Idle | `Offline] array=[| `Idle |]) ~(beforeDate: TestsUtils.Datetime.t) () =
  let onlineStatuses = Some onlineStatuses in
  let beforeDate = Some (TestsUtils.Datetime.serialize beforeDate) in
  let args = [%mel.obj {statuses= onlineStatuses; beforeDate= beforeDate}] in
  internal_makeConnectionId connectionParentDataId args
module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types

  let getConnectionNodes: Types.fragment_friendsConnection option -> Types.fragment_friendsConnection_edges_node array = fun connection -> 
    begin match connection with
      | None -> [||]
      | Some connection -> 
        begin match connection.edges with
          | None -> [||]
          | Some edges -> edges
            |. Melange_relay.Internal.internal_keepMap ~f:(function 
              | None -> None
              | Some edge -> edge.node
            )
        end
    end


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.fragmentNode


let node: operationType = [%mel.raw {json| {
  "argumentDefinitions": [
    {
      "defaultValue": null,
      "kind": "LocalArgument",
      "name": "beforeDate"
    },
    {
      "defaultValue": 2,
      "kind": "LocalArgument",
      "name": "count"
    },
    {
      "defaultValue": "",
      "kind": "LocalArgument",
      "name": "cursor"
    },
    {
      "defaultValue": [
        "Idle"
      ],
      "kind": "LocalArgument",
      "name": "onlineStatuses"
    },
    {
      "defaultValue": true,
      "kind": "LocalArgument",
      "name": "test"
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
          "friendsConnection"
        ]
      }
    ]
  },
  "name": "TestConnections_user",
  "selections": [
    {
      "condition": "test",
      "kind": "Condition",
      "passingValue": true,
      "selections": [
        {
          "alias": "friendsConnection",
          "args": [
            {
              "kind": "Variable",
              "name": "beforeDate",
              "variableName": "beforeDate"
            },
            {
              "kind": "Variable",
              "name": "statuses",
              "variableName": "onlineStatuses"
            }
          ],
          "concreteType": "UserConnection",
          "kind": "LinkedField",
          "name": "__TestConnections_user_friendsConnection_connection",
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
      ]
    },
    {
      "kind": "ClientExtension",
      "selections": [
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "__id",
          "storageKey": null
        }
      ]
    }
  ],
  "type": "User",
  "abstractKey": null
} |json}]

