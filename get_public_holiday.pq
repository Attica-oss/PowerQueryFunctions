let
  // ----------------------- Documentation ----------------------- 
  documentation_ = [
    Documentation.Name = "get_public_holiday#(cr,lf)",
    Documentation.Description
      = " Creates a list of public holiday dates based on the year.#(cr,lf)",
    Documentation.LongDescription
      = " Creates a list of public holiday dates based on the year.#(cr,lf)",
    Documentation.Category = " Table#(cr,lf)",
    Documentation.Source
      = " https://github.com/Attica-oss. #(cr,lf)",
    Documentation.Author = " G.Mounac . #(cr,lf)",
    Documentation.Examples = {
      [
        Description
          = " https://github.com/Attica-oss .#(cr,lf)",
        Code = " #(cr,lf) ",
        Result = " #(cr,lf)"
      ]
    }
  ],


// ---------------------------function --------------------------

function_ = (Year as number) =>
  let
/*    public_holidays = []


    
    
    */

    
    fixed_holiday = {#date(Year,1,1),
                     #date(Year,1,2),
                     #date(Year,5,1),
                     #date(Year,6,18),
                     #date(Year,6,29),
                     #date(Year,8,15),
                     #date(Year,11,1),
                     #date(Year,12,8),
                     #date(Year,12,25)
                        },

    // Calculate Easter Sunday date
    a = Number.Mod(Year,9),
    b = Number.IntegerDivide(Year,100),
    c = Number.Mod(Year,100),

    d1 = b+8,
    d2 = Number.IntegerDivide(b - d1, 25+1),
    d3 = Number.IntegerDivide(d2,3),
    d4 = Number.IntegerDivide(9 * a + b - b,4),
    d5 = d4 - d3 + 15,


    d = Number.Mod(d5,30),

    e1 = Number.Mod(b,4),
    e2 = Number.IntegerDivide(c,4),
    e3 = Number.Mod(c,4),
    e4 = (32 + 2 * e1 + 2 * e2 - d - e3),

    e = Number.Mod(e4,7),

    f1 = ( a + 11 * d + 22 * e),
    f2 = Number.IntegerDivide(f1,451),

    f = d + e + 7 * f2 + 114,

    month = Number.IntegerDivide(f,31),
    day = Number.Mod(f,31)+1,

    easter_date = #date(Year,month,day),
    easter_monday = easter_date + #duration(1,0,0,0),
    holy_saturday = easter_date - #duration(1,0,0,0),
    good_friday = easter_date - #duration(2,0,0,0),
    corpus_christi = easter_date + #duration(60,0,0,0),

    religious = {easter_date,easter_monday,good_friday,holy_saturday,corpus_christi},



    refund_monday = List.Accumulate(
        fixed_holiday,
        {},
            ( state, current ) =>
  state & ( if Date.DayOfWeek(current) = 6 then {current + #duration(1,0,0,0)} else {})
    
   )

in
    List.Sort(List.Combine({refund_monday,religious,fixed_holiday})),

      // ----------------------- New Function Type ----------------------- 
  type_ = type function (
    Year as (type number)
    ) as table
    meta documentation_,
  // Type as Table
  Result = Value.ReplaceType(function_, type_)
in
  Result
