(* @sourceLoc Test_paginationInNode.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment_friendsConnection_edges_node = {
    id: string [@live];
    fragmentRefs: [ | `TestPaginationInNode_user] Melange_relay.fragmentRefs;
  }
  and fragment_friendsConnection_edges = {
    node: fragment_friendsConnection_edges_node option;
  }
  and fragment_friendsConnection = {
    edges: fragment_friendsConnection_edges option array option;
  }
  type fragment = {
    friendsConnection: fragment_friendsConnection;
    id: string [@live];
  }
end

module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"friendsConnection_edges_node":{"f":""}}}|json}
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
  [> | `TestPaginationInNode_query] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

let connectionKey = "TestPaginationInNode_friendsConnection"

[@@mel.inline]
[%%private
  external internal_makeConnectionId: Melange_relay.dataId -> (_ [@mel.as "TestPaginationInNode_friendsConnection"]) -> 'arguments -> Melange_relay.dataId = "getConnectionID"
[@@live] [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

]let makeConnectionId (connectionParentDataId: Melange_relay.dataId) ?(onlineStatuses: [`Online | `Idle | `Offline] array option) () =
  let args = [%mel.obj {statuses= onlineStatuses}] in
  internal_makeConnectionId connectionParentDataId args
module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types

  let getConnectionNodes: Types.fragment_friendsConnection -> Types.fragment_friendsConnection_edges_node array = fun connection -> 
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


[%%private let makeNode ocaml_graphql_node_TestPaginationInNodeRefetchQuery: operationType = 
  ignore ocaml_graphql_node_TestPaginationInNodeRefetchQuery;
  [%raw {json|(function(){
var v0 = [
  "friendsConnection"
],
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
};
return {
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
    },
    {
      "defaultValue": null,
      "kind": "LocalArgument",
      "name": "onlineStatuses"
    }
  ],
  "kind": "Fragment",
  "metadata": {
    "connection": [
      {
        "count": "count",
        "cursor": "cursor",
        "direction": "forward",
        "path": (v0/*: any*/)
      }
    ],
    "refetch": {
      "connection": {
        "forward": {
          "count": "count",
          "cursor": "cursor"
        },
        "backward": null,
        "path": (v0/*: any*/)
      },
      "fragmentPathInResult": [
        "node"
      ],
      "operation": ocaml_graphql_node_TestPaginationInNodeRefetchQuery,
      "identifierInfo": {
        "identifierField": "id",
        "identifierQueryVariableName": "id"
      }
    }
  },
  "name": "TestPaginationInNode_query",
  "selections": [
    {
      "alias": "friendsConnection",
      "args": [
        {
          "kind": "Variable",
          "name": "statuses",
          "variableName": "onlineStatuses"
        }
      ],
      "concreteType": "UserConnection",
      "kind": "LinkedField",
      "name": "__TestPaginationInNode_friendsConnection_connection",
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
                (v1/*: any*/),
                {
                  "args": null,
                  "kind": "FragmentSpread",
                  "name": "TestPaginationInNode_user"
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
    },
    (v1/*: any*/)
  ],
  "type": "User",
  "abstractKey": null
};
})()|json}]
]
let node: operationType = makeNode TestPaginationInNodeRefetchQuery_graphql.node

