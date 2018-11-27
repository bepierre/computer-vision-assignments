function [n] = nTrials(inlierRatio,nSamples,desiredConfidence)

n = round(log(1-desiredConfidence)/log(1-inlierRatio^nSamples));

end