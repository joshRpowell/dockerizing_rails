class ProgressUpdateJob
  include Sidekiq::Worker
  def perform(book_id)
    book = Book.find(book_id)
    read = book.activities.sum(:pages_read)
    progress = [(100.0 * read / book.pages).round, 100.0].min
    book.update!(progress: progress)
  end
end
