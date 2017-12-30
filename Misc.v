Require Import List Ensembles Omega.

Lemma Forall_map X Y (P : Y -> Prop) (f : X -> Y) l :
  Forall (fun x => P (f x)) l -> Forall P (map f l).
Proof. induction 1; simpl; eauto. Qed.

Lemma Forall_map_inv X Y (P : Y -> Prop) (f : X -> Y) l :
  Forall P (map f l) -> Forall (fun x => P (f x)) l.
Proof. induction l; inversion 1; eauto. Qed.

Lemma In_Empty_dec X x :
  { In X (Empty_set _) x } + { ~ In _ (Empty_set _) x }.
Proof. right. inversion 1. Defined.

Lemma In_Union_dec X S T x :
  { In X S x } + { ~ In _ S x } ->
  { In _ T x } + { ~ In _ T x } ->
  { In _ (Union _ S T) x } + { ~ In _ (Union _ S T) x }.
Proof.
  intros HS HT.
  destruct HS; [ left; eauto with sets | ].
  destruct HT; [ left; eauto with sets | ].
  right. inversion 1; eauto with sets.
Defined.

Lemma Empty_bound :
  { x | forall y, In _ (Empty_set _) y -> y < x }.
Proof. exists 0. inversion 1. Defined.

Lemma Singleton_bound z :
  { x | forall y, In _ (Singleton _ z) y -> y < x }.
Proof. exists (S z). inversion 1. omega. Defined.

Lemma Union_bound X Y :
  { x | forall y, In _ X y -> y < x } ->
  { x | forall y, In _ Y y -> y < x } ->
  { x | forall y, In _ (Union _ X Y) y -> y < x }.
Proof.
  Local Hint Resolve Nat.lt_le_trans.
  intros [ x ? ] [ y ? ].
  destruct (le_ge_dec x y); [ exists y | exists x ]; inversion 1; subst; eauto.
Defined.
