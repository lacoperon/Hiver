type screepsConstant =
  | ERR_NOT_IN_RANGE

let toNum(sc : screepsConstant) : int =
  match sc with
  | ERR_NOT_IN_RANGE -> -9
