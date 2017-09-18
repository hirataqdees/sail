(*Generated by Lem from show.lem.*)
(** [show.lem] exports the typeclass [Show] and associated functions for pretty
  * printing arbitrary values.
  *)

open Lem_function
open Lem_list
open Lem_maybe
open Lem_num
open Lem_string
open Lem_string_extra

type 'a show_class={
  show_method : 'a -> string
}

(** [string_of_unit u] produces a string representation of unit [u].
  *)
(*val string_of_unit : unit -> string*)
let string_of_unit u:string=  "()"

let instance_Show_Show_unit_dict:(unit)show_class= ({

  show_method = string_of_unit})

(** [string_of_bool b] produces a string representation of boolean [b].
  *)
(*val string_of_bool : bool -> string*)
let string_of_bool b:string=  
 ((match b with
    | true  -> "true"
    | false -> "false"
  ))

let instance_Show_Show_bool_dict:(bool)show_class= ({

  show_method = string_of_bool})

(** To give control over extraction as instances cannot be target specific, but
  * the functions they are bound to can be...
  *)
(*val string_of_string : string -> string*)
let string_of_string x:string=  x

let instance_Show_Show_string_dict:(string)show_class= ({

  show_method = string_of_string})

(** [string_of_pair p] produces a string representation of pair [p].
  *)
(*val string_of_pair : forall 'a 'b. Show 'a, Show 'b => ('a * 'b) -> string*)
let string_of_pair dict_Show_Show_a dict_Show_Show_b (left, right):string=  
 ("(" ^ (dict_Show_Show_a.show_method left ^ (", " ^ (dict_Show_Show_b.show_method right ^ ")"))))

let instance_Show_Show_tup2_dict dict_Show_Show_a dict_Show_Show_b:('a*'b)show_class= ({

  show_method = 
  (string_of_pair dict_Show_Show_a dict_Show_Show_b)})

(** [string_of_triple p] produces a string representation of triple [p].
  *)
(*val string_of_triple : forall 'a 'b 'c. Show 'a, Show 'b, Show 'c => ('a * 'b * 'c) -> string*)
let string_of_triple dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c (left, middle, right):string=  
 ("(" ^ (dict_Show_Show_a.show_method left ^ (", " ^ (dict_Show_Show_b.show_method middle ^ (", " ^ (dict_Show_Show_c.show_method right ^ ")"))))))

let instance_Show_Show_tup3_dict dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c:('a*'b*'c)show_class= ({

  show_method = 
  (string_of_triple dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c)})

(** [string_of_quad p] produces a string representation of quad [p].
  *)
(*val string_of_quad : forall 'a 'b 'c 'd. Show 'a, Show 'b, Show 'c, Show 'd => ('a * 'b * 'c * 'd) -> string*)
let string_of_quad dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c dict_Show_Show_d (left, middle1, middle2, right):string=  
 ("(" ^ (dict_Show_Show_a.show_method left ^ (", " ^ (dict_Show_Show_b.show_method middle1 ^ (", " ^ (dict_Show_Show_c.show_method middle2 ^ (", " ^ (dict_Show_Show_d.show_method right ^ ")"))))))))

let instance_Show_Show_tup4_dict dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c dict_Show_Show_d:('a*'b*'c*'d)show_class= ({

  show_method = 
  (string_of_quad dict_Show_Show_a dict_Show_Show_b dict_Show_Show_c
     dict_Show_Show_d)})

(** [string_of_maybe m] produces a string representation of maybe value [m].
  *)
(*val string_of_maybe : forall 'a. Show 'a => maybe 'a -> string*)
let string_of_maybe dict_Show_Show_a m:string=  
 ((match m with
    | None -> "Nothing"
    | Some e  -> "Just " ^ 
  dict_Show_Show_a.show_method e
  ))

let instance_Show_Show_Maybe_maybe_dict dict_Show_Show_a:('a option)show_class= ({

  show_method = 
  (string_of_maybe dict_Show_Show_a)})

(** [show_else s m] produces a string representation of maybe [m], using [s] 
  * in the case [m] = Nothing. *)
(*val show_else : forall 'a. Show 'a => string -> maybe 'a -> string*)
let show_else dict_Show_Show_a subst m:string=    
  ((match m with 
          Some x -> dict_Show_Show_a.show_method x 
        | None -> subst 
    ))

(** [string_of_nat m] produces a string representation of nat value [m].
  *)
(*val string_of_nat : nat -> string*)

let instance_Show_Show_nat_dict:(int)show_class= ({

  show_method = Pervasives.string_of_int})

let instance_Show_Show_Num_natural_dict:(Nat_big_num.num)show_class= ({

  show_method = Nat_big_num.to_string})

(*val string_of_integer : integer -> string*)

let instance_Show_Show_Num_integer_dict:(Nat_big_num.num)show_class= ({

  show_method = Nat_big_num.to_string})