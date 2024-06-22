#pragma once
#include "config.hpp"
#include "common/buffer.hpp"

namespace moon
{
    class message final
    {
    public:
        static message with_empty(){
            return message{buffer_ptr_t{}};
        }

        message()
        :data_(buffer::make_unique())
        {
        }

        explicit message(size_t capacity)
            :data_(buffer::make_unique(capacity))
        {
        }

        explicit message(buffer_ptr_t&& v)
            :data_(std::move(v))
        {
            
        }

        ~message() = default;

        message(const message&) = delete;

        message& operator=(const message&) = delete;

        message(message&& other) noexcept
            :type_(std::exchange(other.type_, uint8_t{}))
            , sender_(std::exchange(other.sender_, 0))
            , receiver_(std::exchange(other.receiver_, 0))
            , sessionid_(std::exchange(other.sessionid_, 0))
            , data_(std::move(other.data_))
        {
        }

        message& operator=(message&& other) noexcept
        {
            if (this != std::addressof(other))
            {
                type_ = std::exchange(other.type_, uint8_t{});
                sender_ = std::exchange(other.sender_, 0);
                receiver_ = std::exchange(other.receiver_, 0);
                sessionid_ = std::exchange(other.sessionid_, 0);
                data_ = std::move(other.data_);
            }
            return *this;
        }

        void set_sender(uint32_t serviceid)
        {
            sender_ = serviceid;
        }

        uint32_t sender() const
        {
            return sender_;
        }

        void set_receiver(uint32_t serviceid)
        {
            receiver_ = serviceid;
        }

        uint32_t receiver() const
        {
            return receiver_;
        }

        void set_sessionid(int64_t v)
        {
            sessionid_ = v;
        }

        int64_t sessionid() const
        {
            return sessionid_;
        }

        void set_type(uint8_t v)
        {
            type_ = v;
        }

        uint8_t type() const
        {
            return type_;
        }

        void write_data(std::string_view s)
        {
            assert(data_);
            data_->write_back(s.data(), s.size());
        }

        const char* data() const
        {
            return data_ ? data_->data() : nullptr;
        }

        size_t size() const
        {
            return data_ ? data_->size():0;
        }

        buffer_ptr_t into_buffer()
        {
            return std::move(data_);
        }

        buffer* as_buffer()
        {
            return data_ ? data_.get() : nullptr;
        }

    private:
        uint8_t type_ = 0;
        uint32_t sender_ = 0;
        uint32_t receiver_ = 0;
        int64_t sessionid_ = 0;
        buffer_ptr_t data_;
    };
};


