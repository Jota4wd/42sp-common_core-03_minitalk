# **************************************************************************** #
#                             Minitalk Makefile                                #
# **************************************************************************** #

# Executáveis
NAME_SERVER		= server
NAME_CLIENT		= client
NAME_SERVER_B	= server_bonus
NAME_CLIENT_B	= client_bonus

# Diretórios
SRC_DIR			= srcs
SRC_BONUS_DIR	= srcs_bonus
INC_DIR			= includes
LIBFT_DIR		= libft

# Compilador e flags
CC				= cc
CFLAGS			= -Wall -Wextra -Werror
RM				= rm -f

# Includes e libft
INCLUDES		= -I$(INC_DIR) -I$(LIBFT_DIR)/include
LIBFT			= $(LIBFT_DIR)/libft.a
LIBS			= -L$(LIBFT_DIR) -lft

# Cores (opcional, ajuda na legibilidade)
GREEN			= \033[0;32m
YELLOW			= \033[1;33m
NC				= \033[0m

# --------------------------------------------------------------------------- #
#                                FONTES                                       #
# --------------------------------------------------------------------------- #

# Fontes obrigatórias
SRCS_SERVER		= $(SRC_DIR)/server.c
SRCS_CLIENT		= $(SRC_DIR)/client.c

# Fontes bônus
SRCS_SERVER_B	= $(SRC_BONUS_DIR)/server_bonus.c
SRCS_CLIENT_B	= $(SRC_BONUS_DIR)/client_bonus.c

# Objetos (substitui .c por .o)
OBJS_SERVER		= $(SRCS_SERVER:.c=.o)
OBJS_CLIENT		= $(SRCS_CLIENT:.c=.o)
OBJS_SERVER_B	= $(SRCS_SERVER_B:.c=.o)
OBJS_CLIENT_B	= $(SRCS_CLIENT_B:.c=.o)

# --------------------------------------------------------------------------- #
#                                REGRAS                                       #
# --------------------------------------------------------------------------- #

.PHONY: all mandatory bonus clean fclean re libft

all: mandatory

mandatory: $(NAME_SERVER) $(NAME_CLIENT)

bonus: $(NAME_SERVER_B) $(NAME_CLIENT_B)

# --- Compila libft se necessário ---
$(LIBFT):
	@echo "$(YELLOW)Compilando libft...$(NC)"
	@$(MAKE) -C $(LIBFT_DIR) --no-print-directory

# --- Regras de linkagem (usam objetos e a libft.a) ---
$(NAME_SERVER): $(OBJS_SERVER) $(LIBFT)
	@$(CC) $(CFLAGS) $(OBJS_SERVER) $(INCLUDES) $(LIBS) -o $@
	@echo "$(GREEN)[OK]$(NC) $@ compilado com sucesso"

$(NAME_CLIENT): $(OBJS_CLIENT) $(LIBFT)
	@$(CC) $(CFLAGS) $(OBJS_CLIENT) $(INCLUDES) $(LIBS) -o $@
	@echo "$(GREEN)[OK]$(NC) $@ compilado com sucesso"

$(NAME_SERVER_B): $(OBJS_SERVER_B) $(LIBFT)
	@$(CC) $(CFLAGS) $(OBJS_SERVER_B) $(INCLUDES) $(LIBS) -o $@
	@echo "$(GREEN)[OK]$(NC) $@ (bonus) compilado com sucesso"

$(NAME_CLIENT_B): $(OBJS_CLIENT_B) $(LIBFT)
	@$(CC) $(CFLAGS) $(OBJS_CLIENT_B) $(INCLUDES) $(LIBS) -o $@
	@echo "$(GREEN)[OK]$(NC) $@ (bonus) compilado com sucesso"

# --- Regra genérica para criar .o a partir de .c ---
%.o: %.c
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# --- Limpeza ---
clean:
	@$(MAKE) clean -C $(LIBFT_DIR) --no-print-directory
	@$(RM) $(OBJS_SERVER) $(OBJS_CLIENT) $(OBJS_SERVER_B) $(OBJS_CLIENT_B)
	@echo "$(YELLOW)Objetos removidos$(NC)"

fclean: clean
	@$(MAKE) fclean -C $(LIBFT_DIR) --no-print-directory
	@$(RM) $(NAME_SERVER) $(NAME_CLIENT) $(NAME_SERVER_B) $(NAME_CLIENT_B)
	@echo "$(YELLOW)Executáveis removidos$(NC)"

re: fclean all
