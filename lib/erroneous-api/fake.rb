module ErroneousAPI
  class Fake
    def self.parse_deploy_fail(log_text)
      lines = log_text.split("\n")
      bad_line = lines.detect{|l| l.match(/ERROR/)}
      {
        :lines => [lines.index(bad_line) + 1],
        :summary => "you had ERROR.",
        :details => "retry by doing this thing that takes multiple sentences to descibe. bla. bla.",
      }
    end
  end
end