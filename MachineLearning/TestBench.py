import difflib
import subprocess
import os
from collections import Counter
import operator

program = "TrainAndTest"
images = os.listdir("test_images")[1:]
ratios = []
word_lengths = []
missed_letters = {}


def create_breakout(result, word):
    if result != word:
        for i, s in enumerate(difflib.ndiff(result,  word)):
            if s[0] == ' ':
                continue
            elif s[0] == '+':
                if s[-1] not in missed_letters:
                    missed_letters[s[-1]] = 1
                else:
                    missed_letters[s[-1]] += 1


def test_unique_letters(counter):
    sentence = "THE QUICK BROWN FOX JUMP JUMPED OVER LAZY DOG".split()
    tested_image_count = 0
    for image in images:
        word = ''.join([i for i in image[:-4] if not i.isdigit()])
        if word in sentence:
                tested_image_count += 1
                image_path = "test_images/" + image
                out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
                result = out.split(" = ")[1].rstrip()
                letter_count = Counter(word)
                counter += letter_count
                if word != result:
                    create_breakout(result, word)
                ratio = difflib.SequenceMatcher(None, result, word).ratio()
                word_lengths.append(len(word))
                ratios.append(ratio)
    return tested_image_count


def test_rick_roll():
    sentence = "RICK ROLL NEVER GONNA GIVE YOU UP LET DOWN RUN AROUND AND YOU".split()
    for image in images:
        word = ''.join([i for i in image[:-4] if not i.isdigit()])
        if word in sentence:
            image_path = "test_images/" + image
            out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
            result = out.split(" = ")[1].rstrip()
            if word != result:
                    create_breakout(result, word)
            ratio = difflib.SequenceMatcher(None, result, word).ratio()
            word_lengths.append(len(word))
            ratios.append(ratio)


def test_team_names(self):
    sentence = "JENNA ERIC LUKE OSAMA DOR".split()
    for image in images:
        word = ''.join([i for i in image[:-4] if not i.isdigit()])
        if word in sentence:
            with self.subTest(CASE=image):
                image_path = "test_images/" + image
                out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
                result = out.split(" = ")[1].rstrip()
                create_breakout(result, word)
                self.assertEqual(result, word)


if __name__ == '__main__':
    counter = Counter()

    image_count = test_unique_letters(counter)
    letter_count = sum(counter.values())
    # test_rick_roll(counter)
    # test_team_names(counter)
    found_letters = 0
    for i in range(len(word_lengths)):
        found_letters += int(word_lengths[i] * ratios[i])

    overall_hit_rate = found_letters / (sum(word_lengths))
    letter_hit_rate = {}
    print("Tested " + str(image_count) + " images with " + str(letter_count) + " letters")
    print("The overall hitrate is : " + str(overall_hit_rate))
    sorted_missed_letters = sorted(missed_letters.items(), key=operator.itemgetter(1), reverse=True)
    print("The most common letters in the testbench are: ")
    print(counter.most_common())
    print("The most common missed letters are: ")
    print(sorted_missed_letters)
    for letter in missed_letters:
        letter_hit_rate[letter] = "{0:.2f}".format(((counter[letter] - missed_letters[letter])/counter[letter])*100)
    sorted_letter_hit_rate = sorted(letter_hit_rate.items(), key=operator.itemgetter(1))
    print("Hitrate by letter: ")
    print(sorted_letter_hit_rate)
