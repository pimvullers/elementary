# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A very simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://launchpad.net/properties-cpp"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/p/properties-cpp/properties-cpp_0.0.1+14.10.20140730.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/properties-cpp-0.0.1+14.10.20140730"

src_prepare() {
	sed -i '/add_subdirectory(tests)/d' CMakeLists.txt
}
