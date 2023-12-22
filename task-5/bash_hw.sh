#!/bin/bash

GREEN='\e[32m'
RED='\e[31m'
RESET='\e[0m'

step_count=1
answers_amount=0
correct_answers=0
answers=()

while :
do
  echo "Step: ${step_count}"

  generated_answer=${RANDOM: -1}

  read -p "Please enter a number from 0 to 9 (q to quit): " input

  case "${input}" in
    [0-9])
      answers_amount=$(( answers_amount + 1 ))

      if [[ "${input}" == "${generated_answer}" ]]
      then
        echo "Hit! My number: ${generated_answer}"
        correct_answers=$(( correct_answers + 1 ))

        colored_answer="${GREEN}${generated_answer}${RESET}"
      else
        echo "Miss! My number: ${generated_answer}"

        colored_answer="${RED}${generated_answer}${RESET}"
      fi

      answers=("${answers[@]}" "${colored_answer}")

      let hit_percent=correct_answers*100/answers_amount
      let miss_percent=100-hit_percent

      echo "Hit: ${hit_percent}%" "Miss: ${miss_percent}%"

      if [[ "${#answers[@]}" -lt 10 ]]
      then
        echo -e "Numbers: ${answers[@]}"
      else
        echo -e "Numbers: ${answers[@]: -10}"
      fi

      step_count=$(( step_count + 1 ))
    ;;
    q)
      echo "Game is finished."
      exit 0
    ;;
    *)
      echo "Invalid input! Try again."
  esac
done
