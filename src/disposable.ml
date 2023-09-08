type nonrec t

external dispose : t -> unit = "dispose" [@@send]
external ignore : t -> unit = "%ignore"
