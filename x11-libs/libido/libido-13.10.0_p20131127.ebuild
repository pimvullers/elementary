# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vala autotools-utils

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/ido_13.10.0%2B14.04.20131127.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	>=dev-libs/glib-2.37:2
	>=x11-libs/gtk+-3.8.2:3[ubuntu]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
S="${WORKDIR}/ido-13.10.0+14.04.20131127"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	sed -i "s/-Werror//" configure.ac src/Makefile.am

	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	autotools-utils_src_configure VALA_API_GEN="${VAPIGEN}"
}
