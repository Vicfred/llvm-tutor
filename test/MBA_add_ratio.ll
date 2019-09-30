; RUN: opt -load ../lib/libMBAAdd%shlibext -legacy-mba-add -mba-ratio=1 -S %s  | FileCheck -check-prefix=MBA %s
; RUN: opt -load ../lib/libMBAAdd%shlibext -legacy-mba-add -mba-ratio=0 -S %s  | FileCheck -check-prefix=NO_MBA %s

; Verify that -mba-ratio has the expected effect.
; 1st '+'
; MBA-DAG:   {{%[0-9]+}} = xor i8 %in_0, %in_1
; MBA-DAG:   {{%[0-9]+}} = and i8 %in_0, %in_1
; MBA-DAG:   {{%[0-9]+}} = mul i8 2, {{%[0-9]+}}
; MBA-NOT:   %5 = mul i8 {{%[0-9]+}}, 39
; MBA-DAG:   {{%[0-9]+}} = add i8 {{%[0-9]+}}, {{%[0-9]+}}
; MBA:       %5 = mul i8 {{%[0-9]+}}, 39
; MBA-NEXT:  %6 = add i8 %5, 23
; MBA-NEXT:  %7 = mul i8 %6, -105
; MBA-NEXT:  %8 = add i8 %7, 111
; 2nd '+'
; MBA-DAG:   {{%[0-9]+}} = xor i8 %in_2, %8
; MBA-DAG:   {{%[0-9]+}} = and i8 %in_2, %8
; MBA-DAG:   {{%[0-9]+}} = mul i8 2, {{%[0-9]+}}
; MBA-NOT:   %13 = mul i8 {{%[0-9]+}}, 39
; MBA-DAG:   {{%[0-9]+}} = add i8 {{%[0-9]+}}, {{%[0-9]+}}
; MBA:       %13 = mul i8 {{%[0-9]+}}, 39
; MBA-NEXT:  %14 = add i8 %13, 23
; MBA-NEXT:  %15 = mul i8 %14, -105
; MBA-NEXT:  %16 = add i8 %15, 111
; 3rd '+'
; MBA-DAG:   {{%[0-9]+}} = xor i8 %in_3, %16
; MBA-DAG:   {{%[0-9]+}} = and i8 %in_3, %16
; MBA-DAG:   {{%[0-9]+}} = mul i8 2, {{%[0-9]+}}
; MBA-NOT:   %21 = mul i8 {{%[0-9]+}}, 39
; MBA-DAG:   {{%[0-9]+}} = add i8 {{%[0-9]+}}, {{%[0-9]+}}
; MBA:       %21 = mul i8 {{%[0-9]+}}, 39
; MBA-NEXT:  %22 = add i8 %21, 23
; MBA-NEXT:  %23 = mul i8 %22, -105
; MBA-NEXT:  %24 = add i8 %23, 111
; 4th '+'
; MBA-DAG:   {{%[0-9]+}} = xor i8 %in_4, %24
; MBA-DAG:   {{%[0-9]+}} = and i8 %in_4, %24
; MBA-DAG:   {{%[0-9]+}} = mul i8 2, {{%[0-9]+}}
; MBA-NOT:   %29 = mul i8 {{%[0-9]+}}, 39
; MBA-DAG:   {{%[0-9]+}} = add i8 {{%[0-9]+}}, {{%[0-9]+}}
; MBA:       %29 = mul i8 {{%[0-9]+}}, 39
; MBA-NEXT:  %30 = add i8 %29, 23
; MBA-NEXT:  %31 = mul i8 %30, -105
; MBA-NEXT:  %32 = add i8 %31, 111
; MBA-NEXT:  ret i8 %32

; 1st '+'
; NO_MBA:  %1 = add nsw i8 %in_0, %in_1
; 2nd '+'
; NO_MBA-NEXT:  %2 = add nsw i8 %in_2, %1
; 3rd '+'
; NO_MBA-NEXT:  %3 = add nsw i8 %in_3, %2
; 4th '+'
; NO_MBA-NEXT:  %4 = add nsw i8 %in_4, %3
; NO_MBA-NO:  xor 
; NO_MBA-NO:  and
; NO_MBA-NO:  mul
; NO_MBA-NEXT:  ret i8 %4

define i8 @main(i8 %in_0, i8 %in_1, i8 %in_2, i8 %in_3, i8 %in_4)  {
  %1 = add nsw i8 %in_0, %in_1
  %2 = add nsw i8 %in_2, %1
  %3 = add nsw i8 %in_3, %2
  %4 = add nsw i8 %in_4, %3
  ret i8 %4
}
