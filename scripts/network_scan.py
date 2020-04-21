import argparse
import logging
import os
import socket
import subprocess


def main():
	for address_ending in range(1, 99):
		address = LOCAL_NETWORK + str(address_ending)
		res = subprocess.call(['ping', '-c', '1', "-W", "0.5", address], stdout=FNULL, stderr=subprocess.STDOUT)
		if res == 0:
			try:
				hostname = socket.gethostbyaddr(address)
				real_hostname = hostname[0].split(".")[0]
				real_address = hostname[2][0]
				logging.info("Found %s on address %s!" % (real_hostname, real_address))
				logging.debug(hostname)
			except socket.error:
				logging.error("Couldn't get hostname from %s!" % address)


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument("--debug", "-d", help="Show debug output.", action="store_true")
	args = parser.parse_args()

	if args.debug:
		log_level = logging.DEBUG
	else:
		log_level = logging.INFO
	logging.basicConfig(level=log_level, format='%(levelname)s - %(message)s')

	FNULL = open(os.devnull, 'w')

	LOCAL_NETWORK = socket.gethostbyname(socket.gethostname())
	LOCAL_NETWORK = LOCAL_NETWORK[:LOCAL_NETWORK.rindex(".") + 1]

	main()
