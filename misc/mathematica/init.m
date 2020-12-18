(** User Mathematica initialization file **)
System`clear:=Clear["Global`*"]
System`clc:=Module[{obj},obj=EvaluationCell[];
SelectionMove[obj,All,Notebook];
NotebookDelete[];
"clc"]

SetOptions[$FrontEndSession,Magnification->1.25]
