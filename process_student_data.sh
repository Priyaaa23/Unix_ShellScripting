input_file="StudentData.txt"
output_file="ModifiedStudentData.txt"

while IFS=',' read -r StudentID Age DOB Gender SocioeconomicStatus SchoolType GradeLevel AttendanceRate GPA DisciplineIncidents ExtraCurAct ParentalCare GraduationFlag DropoutFlag Location; do
        if [[ "$DOB" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{2}$ ]]; then
                dob_day="${DOB%%-*}"
                dob_month="${DOB%-*}"
                dob_month="${dob_month#*-}"
                dob_year="${DOB##*-}"
                DOB="${dob_day}-${dob_month}-20${dob_year}"
        fi

        Location=$(echo "$Location" | xargs)
        if [[ -z "$Location" || "$Location" =~ ^[[:space:]]*$ || "$Location" == "0" ]]; then
                Location="Delhi"
        fi

        echo "$StudentID,$Age,$DOB,$Gender,$SocioeconomicStatus,$SchoolType,$GradeLevel,$AttendanceRate,$GPA,$DisciplineIncidents,$ExtraCurAct,$ParentalCare,$GraduationFlag,$DropoutFlag,$Location" >> "$output_file"
done < "$input_file"

echo "Processing complete! File saved at: $output_file"


