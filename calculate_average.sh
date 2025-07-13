#!/bin/bash
 
input_file="StudentData.txt"
 
declare -A sum_disciplines

declare -A count_parents
 
while IFS=',' read -r StudentID Age DOB Gender SocieconomicStatus SchoolType GradeLevel AttendanceRate GPA DisciplineIncidents ExtraCurAct ParentalCare GraduationFlag DropoutFlag Location; do

    if [[ "$ParentalCare" == "ParentalCare" ]]; then

        continue

    fi
 
    if [[ "$DisciplineIncidents" =~ ^[0-9]+$ ]]; then

        sum_disciplines["$ParentalCare"]=$((sum_disciplines["$ParentalCare"] + DisciplineIncidents))

        count_parents["$ParentalCare"]=$((count_parents["$ParentalCare"] + 1))

    fi

done < "$input_file"
 
echo "Parental Care | Average Discipline Incidents"

echo "--------------------------------------------"

for ParentalCare in "${!sum_disciplines[@]}"; do

    sum=${sum_disciplines["$ParentalCare"]}

    count=${count_parents["$ParentalCare"]}

    average=$(awk "BEGIN {printf \"%.2f\", $sum / $count}")

    printf "%-14s | %s\n" "$ParentalCare" "$average"

done
 
echo "Processing complete!"
 