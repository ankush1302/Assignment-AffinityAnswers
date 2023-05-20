import re

def calculate_profanity(tweet, racial_slurs):
    tweet_lower = tweet.lower()
    
    # Split the tweet into sentences using punctuation marks as delimiters
    sentences = re.split(r'(?<=[.!?])\s+', tweet_lower)
    
    # Calculate the degree of profanity for each sentence
    profanity_scores = 0
    slur_count=0
    total_words=0
    for sentence in sentences:
        # Remove any non-alphanumeric characters and split the sentence into words
        words = re.findall(r'\w+', sentence)
        total_words+=len(words)
        # Count the number of racial slurs present in the sentence
        for word in words:
        	if word in racial_slurs:
        		slur_count+=1
        
    # Calculate the degree of profanity as a ratio of slurs to total words
    profanity_score = slur_count / total_words
  
    return profanity_scores


def main():
    # Assumption: The set of racial slurs is provided as a list of words
    racial_slurs = ['slur1', 'slur2', 'slur3']
    

    # let's suppose we have a file tweets.txt, then:
    with open('tweets.txt', 'r') as file:
        tweets = file.readlines()
    
    for tweet in tweets:
        tweet = tweet.strip()
        if tweet:
            profanity_score = calculate_profanity(tweet, racial_slurs)
       	print(profanity_score)
            

if __name__ == '__main__':
    main()


#important assumptions:

#The input file "tweets.txt" contains one tweet per line.

#The program uses a simple approach to split the tweets into sentences based on punctuation marks like periods,
#exclamation points, and question marks. This approach may not handle all cases perfectly, 
#as it doesn't consider abbreviations, emoticons, or other special cases.