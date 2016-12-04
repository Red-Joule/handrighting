import difflib
import subprocess
import os


program = "TrainAndTest"
images = os.listdir("test_images")[1:]

ratios = []
word_lengths = []


def create_breakout(result, word):
    if result != word:
        print('{} => {}'.format(result, word))
        for i, s in enumerate(difflib.ndiff(result,  word)):
            if s[0] == ' ':
                continue
            elif s[0] == '-':
                print(u'Delete "{}" from position {}'.format(s[-1], i))
            elif s[0] == '+':
                print(u'Add "{}" to position {}'.format(s[-1], i))
        print()


# this is the spec test case.
def test_unique_letters():
    sentence = "THE QUICK BROWN FOX JUMP OVER LAZY DOG".split()
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

# def test_team_names(self):
#     sentence = "JENNA ERIC LUKE OSAMA DOR".split()
#     for image in images:
#         word = ''.join([i for i in image[:-4] if not i.isdigit()])
#         if word in sentence:
#             with self.subTest(CASE=image):
#                 image_path = "test_images/" + image
#                 out = subprocess.check_output(["./TrainAndTest", image_path]).decode("utf-8")
#                 result = out.split(" = ")[1].rstrip()
#                 create_breakout(result, word)
#                 self.assertEqual(result, word)


if __name__ == '__main__':
    # unittest.main()
    test_unique_letters()
    test_rick_roll()
    found = 0
    for i in range(len(word_lengths)):
        found += int(word_lengths[i] * ratios[i])

    hit_rate = found/(sum(word_lengths))
    print(found)
    print(sum(word_lengths))
    print(hit_rate)
