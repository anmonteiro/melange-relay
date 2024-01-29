type nonrec t

external dispose : t -> unit = "dispose" [@@mel.send]
external ignore : t -> unit = "%ignore"
